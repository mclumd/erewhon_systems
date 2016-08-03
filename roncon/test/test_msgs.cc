#include "agent_dispatcher.h"

#include <iostream>
#include <list>

bool test_bcast() {
  using namespace raccoon;
  using namespace std;
  message_passer b,c,d;
  cout << "b@" << &b << " c@" << &c << " d@" << &d << endl;
  broadcast::subscribe(&d, broadcast::USER_CHANNEL);
  broadcast::subscribe(&b, broadcast::USER_CHANNEL);
  broadcast::subscribe(&c, broadcast::USER_CHANNEL);
  text_message msg1(&d,&b,"to d from b");
  text_message msg2(&b,&b,"to b from b");
  text_message msg3(&d,&d,"to d from d");
  broadcast::send(msg1, broadcast::USER_CHANNEL);
  broadcast::send(msg2, broadcast::USER_CHANNEL);
  broadcast::send(msg3, broadcast::USER_CHANNEL);
  cout << "d: "<<d.text_msgs_to_string()<<endl;
  cout << "b: "<<b.text_msgs_to_string()<<endl;
  cout << "c: "<<c.text_msgs_to_string()<<endl;
  cout << broadcast::sdb() << endl;
}

int main(int argc, char** argv) {
  using namespace raccoon;
  using namespace std;

  test_bcast();

  // tcp agents are automatically subscribed to USER

  agents::agent_dispatcher_tcp dis("test",1000);
  agents::agent_dispatcher_tcp d2("test",1001);

  cout << broadcast::sdb() << endl;

  text_message the_msg(NULL,&dis,"Hello?");
  cout << "MSG:" << the_msg.to_string() << endl;
  broadcast::send(the_msg,broadcast::USER_CHANNEL);
  text_message the_msg2(NULL,&dis,"Is it me you're looking for?");
  cout << "MSG:" << the_msg2.to_string() << endl;
  broadcast::send(the_msg2,broadcast::USER_CHANNEL);
  
  cout << "MB(dis)= " << dis.text_msgs_to_string() << endl;
  cout << "MB(d2 )= " << d2.text_msgs_to_string(false) << endl;
  cout << "MB(d2*)= " << d2.text_msgs_to_string(true) << endl;
  cout << "MB(d2 )= " << d2.text_msgs_to_string(false) << endl;

  return 1;

}
