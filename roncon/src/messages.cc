#include "messages.h"

#include <stdio.h>
#include <iostream>
using namespace std;

///////////////////////////////////////////////////
//  GENERAL PURPOSE NAMESPACE FUNCTIONS...

bool raccoon::pass_message(raccoon::message& m) {
  cout << " PM: " << m.to_string() << " from " << hex << m.sender()
       << " to " << hex << m.recipient() << endl;
  m.recipient()->accept_message(m);
  return true;
}

///////////////////////////////////////////////////
//  MESSAGE PASSER CLASS...

raccoon::message_passer::~message_passer() {
  broadcast::unsubscribe(this);
}

void raccoon::message_passer::accept_message(message& msg) { 
  message* q = msg.clone();
  mailbox.push_back(q); 
}

raccoon::message* raccoon::message_passer::pop_message() { 
  message* rv = mailbox.front(); 
  mailbox.pop_front();
  return rv;
}

void raccoon::message_passer::release_message(message* m) {
  mailbox.remove(m);
  delete m;
}

string raccoon::message_passer::text_msgs_to_string(bool release) {
  string rv="(";
  int cnt = 0;
  int msgcnt = mailbox_size();
  for (int i=0; i<msgcnt; i++) {
    message* m = pop_message();
    text_message* tm = dynamic_cast<text_message*>(m);
    if (tm == NULL)
      put_back_in_mb(m);
    else {
      if (cnt != 0) rv+=",";
      rv+= "\""+tm->get_payload()+"\"";
      cnt++;
      if (release) release_message(m);
      else put_back_in_mb(m);
    }
  }
  rv+=")";
  return rv;
}

///////////////////////////////////////////////////
//  BROADCAST CLASS...

raccoon::broadcast raccoon::broadcast::default_bcast;
string raccoon::broadcast::USER_CHANNEL = "user";

void raccoon::broadcast::remove_listener(message_passer* who, string channel) {
  channels[channel].remove(who);
}

void raccoon::broadcast::remove_listener(message_passer* who) {
  for (map<string,list<message_passer*> >::iterator i = channels.begin();
       i != channels.end();
       i++) {
    // this might not work...
    channels[i->first].remove(who);
  }
}

void raccoon::broadcast::send_out(message& msg, string channel) {
  list<message_passer*> audience = channels[channel];
  for (list<message_passer*>::iterator auditiot = audience.begin();
       auditiot != audience.end();
       auditiot++) {
    if (*auditiot != msg.sender()) {
      msg.set_recipient(*auditiot);
      pass_message(msg);
    }
  }
}

void raccoon::broadcast::send(message& msg, string channel) {
  default_bcast.send_out(msg,channel);
}

void raccoon::broadcast::subscribe(message_passer* who, string channel) {
  default_bcast.add_listener(who,channel);
}

void raccoon::broadcast::unsubscribe(message_passer* who, string channel) {
  default_bcast.remove_listener(who,channel);
}

void raccoon::broadcast::unsubscribe(message_passer* who) {
  default_bcast.remove_listener(who);
}

string raccoon::broadcast::to_string() {
  string rv = "[ broadcast: ";
  for (channel_map_t::iterator i = channels.begin();
       i != channels.end();
       i++) {
    rv+="\n  "+i->first+": ";
    list<message_passer*> clist = channels[i->first];
    for (list<message_passer*>::iterator ci = clist.begin();
	 ci != clist.end();
	 ci++) {
      if (ci != clist.begin()) rv+=",";
      char buff[128];
      sprintf(buff,"0x%08x",*ci);
      rv+=(string)buff;
    }
    rv+="\n";  
  }
  rv+="]";
  return rv;
}
