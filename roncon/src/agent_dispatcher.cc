#include "umbc/exceptions.h"
#include "umbc/settings.h"
#include "umbc/logger.h"
#include "umbc/token_machine.h"
#include "umbc/text_utils.h"

#include <errno.h>
#include <stdio.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <exception>
#include <iostream>

#include "agent_dispatcher.h"
#include "agent_player.h"

using namespace std;
using namespace raccoon;
using namespace umbc;

int agents::agent_dispatcher_tcp::DEFAULT_PORT = 7777;

void *_rad_start_server(void *argptr);

agents::agent_dispatcher_tcp::agent_dispatcher_tcp(string nm) :
  agent(nm),server_thread(NULL) {
  my_port = DEFAULT_PORT;
  if (settings::getSysPropertyString("port","") != "")
    my_port=textFunctions::numval(settings::getSysPropertyString("port"));
  broadcast::subscribe(this,broadcast::USER_CHANNEL);
}

agents::agent_dispatcher_tcp::agent_dispatcher_tcp(string nm, int port) : 
  agent(nm),my_port(port),server_thread(NULL),serve(true) {
  broadcast::subscribe(this,broadcast::USER_CHANNEL);
};

agents::agent_dispatcher_tcp::~agent_dispatcher_tcp() {
  broadcast::unsubscribe(this);
}

bool agents::agent_dispatcher_tcp::initialize() {
  int pthread_res = pthread_create(&server_thread,NULL,_rad_start_server,this);
  if (pthread_res < 0)
    umbc::exceptions::signal_exception("failed to create pthread for dispatcher agent (exiting)...");
  pthread_detach(server_thread);
  return true;
}

bool agents::agent_dispatcher_tcp::monitor() {
  return true;
}

bool agents::agent_dispatcher_tcp::shutdown() {
  serve=false;
  return true;
}

string agents::agent_dispatcher_tcp::query(string q) {
  return ignore_msg("unimplemented");  
}

string agents::agent_dispatcher_tcp::command(string q) {
  tokenMachine tlc(q);
  string directive = tlc.nextToken();
  if (directive == "ask") {
    string agnt = tlc.nextToken();
    agent* recip = get_agent(agnt);
    if (recip == NULL) {
      return fail_msg("no agent \""+agnt+"\"");
    }
    else return recip->query(tlc.rest());
  }
  else if (directive == "send") {
    string agnt = tlc.nextToken();    
    agent* recip = get_agent(agnt);
    if (recip == NULL) {
      return fail_msg("no agent \""+agnt+"\"");
    }
    else return recip->command(tlc.rest());
  }
  else if (directive == "agents") {
    string rv="";
    for (list<agent*>::iterator ali = agent_list.begin();
	 ali != agent_list.end();
	 ali++) {
      rv+= " \"" + (*ali)->get_name() + "\"";
    }
    return okay_msg(rv+" ");
  }
  else if (directive == "grammar")
    return okay_msg(generate_grammar());
  else if (directive == "find") {
    cout << "find command received: '" << tlc.rest() << "'" << endl;
    return find_agent(tlc.rest());
  }
  else if (directive == "marv")
    return find_agent("marvin localhost 6665");
  return ignore_msg("unimplemented");
}

string agents::agent_dispatcher_tcp::find_agent(string agentspec) {
  tokenMachine asp(agentspec);
  string aname = asp.nextToken();
  string hname = asp.nextToken();
  string pname = asp.nextToken();
  int pnum = umbc::textFunctions::numval(pname);
  cout << "trying to find agent '" << aname << "' at "
       << hname << " on port " << pname << endl;
  if ((aname != "") && (hname != "") && (pnum != 0)) {
    try {
      agent_player* new_a = new agent_player(aname,hname,pnum);
      agent_list.push_back(new_a);
      if (new_a->initialize())
	return agents::okay_msg(aname+" is ready.");
      else
	return agents::okay_msg(aname+" found but initialized failed.");
    }
    catch (PlayerCc::PlayerError e) {
      return agents::fail_msg(e.GetErrorStr());
    }
  }
  else {
    return agents::fail_msg("invalid agentspec. format is <agent_name> <host> <port>.");
  }
}

agents::agent* agents::agent_dispatcher_tcp::get_agent(string aname) {
  for (list<agent*>::iterator ali = agent_list.begin();
       ali != agent_list.end();
       ali++) {
    if ((*ali)->get_name() == aname)
      return *ali;
  }
  return NULL;
}

string agents::agent_dispatcher_tcp::generate_grammar() {
  umbc::command_grammar tcg;
  // add my own commands here... 
  // okay, so the nonterminal for the active dispatcher will come here
  tcg.add_production("S",grammar_commname());
  publish_grammar(tcg);
  return tcg.to_string();
}

bool agents::agent_dispatcher_tcp::publish_grammar(umbc::command_grammar& cg) {
  cg.add_production(grammar_commname(),"agents");
  cg.add_production(grammar_commname(),"close");
  // cg.add_production(grammar_commname(),"declarations");
  cg.add_production(grammar_commname(),"grammar");
  cg.add_production(grammar_commname(),"find agentname:str hostname:str port:int");
  cg.add_production(grammar_commname(),"ask agent_query");
  cg.add_production(grammar_commname(),"send agent_command");
  
  for (list<agent*>::iterator ali = agent_list.begin();
       ali != agent_list.end();
       ali++) {
    cg.add_production("agent_query",
		      (*ali)->grammar_commname()+" "
		      +(*ali)->grammar_commname()+"_query");
    cg.add_production("agent_command",
		      (*ali)->grammar_commname()+" "
		      +(*ali)->grammar_commname()+"_command");
    (*ali)->publish_grammar(cg);
  }
 }

void *_rad_start_server(void *argptr) {
  agents::agent_dispatcher_tcp* sbc = 
    static_cast<agents::agent_dispatcher_tcp*>(argptr);
  int sockfd, newsockfd, clilen;

  bool up=false;
  char buffer[256];
  struct sockaddr_in serv_addr, cli_addr;
  int n;
  sockfd = socket(AF_INET, SOCK_STREAM, 0);
  if (sockfd < 0) 
    umbc::exceptions::signal_exception("ERROR opening socket");
  bzero((char *) &serv_addr, sizeof(serv_addr));
  serv_addr.sin_family = AF_INET;
  serv_addr.sin_addr.s_addr = INADDR_ANY;
  serv_addr.sin_port = htons(sbc->port());
  if (bind(sockfd, (struct sockaddr *) &serv_addr,
	   sizeof(serv_addr)) < 0) 
    umbc::exceptions::signal_exception("ERROR on binding");
  cout << "[tcp_agnt]:: listening to port " 
       << dec << sbc->port() << endl;
  listen(sockfd,5);
  clilen = sizeof(cli_addr);
  while (sbc->serve_p()) {
    newsockfd = accept(sockfd, 
		       (struct sockaddr *) &cli_addr, 
		       ((socklen_t*)&clilen));
    cout << "[tcp_agnt]:: connection from client initiated..." << endl;
    if (newsockfd < 0) 
      umbc::exceptions::signal_exception("ERROR on accept");
    else up=true;
    while (up) {
      bzero(buffer,256);
      n = read(newsockfd,buffer,255);
      if (n < 0) umbc::exceptions::signal_exception("ERROR reading from socket");
      int q = 1;
      umbc::uLog::annotate(UMBCLOG_HOSTEVENT,"[tcp_agnt]::command received on socket = '"+textFunctions::chopLastChar((string)buffer)+"'");
      if (strncmp(buffer,"close",5) == 0) {
	umbc::uLog::annotate(UMBCLOG_HOSTEVENT,"[tcp_agnt]:: connection closed by client.");
	up=false;
      }
      else {
	int q=0;
	try {
	  string response = sbc->command(buffer);
	  if (umbc::settings::getSysPropertyString("reply","none") == "prolog")
	    response = agents::prologify(response);
	  response+="\n";
	  q = send(newsockfd,response.c_str(),response.length(),MSG_NOSIGNAL);
	}
	catch (exception e) {
	  string explanation = e.what();
	  explanation = agents::fail_msg(explanation);
	  if (umbc::settings::getSysPropertyString("reply","none") == "prolog")
	    explanation = agents::prologify(explanation);
	  explanation+="\n";
	  q = send(newsockfd,explanation.c_str(),
		   explanation.length(),MSG_NOSIGNAL);
	}
	if (q < 0) {
	  char errbuff[512];
	  string exstr = strerror_r(errno,errbuff,512);
	  if (errno == EPIPE) {
#ifdef BREAK_ON_SIGPIPE
	    umbc::exceptions::signal_exception(exstr);
#else
	    umbc::uLog::annotate(UMBCLOG_HOSTEVENT,"[tcp_agnt]:: broken pipe, closing connection...");
	    up=false;
#endif
	  }
	  else umbc::exceptions::signal_exception(exstr);
	}
      }
    }
    close(newsockfd);
  }
  pthread_exit((void*)0);
}

