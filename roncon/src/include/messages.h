#ifndef RC_MESSAGES_BASE
#define RC_MESSAGES_BASE

#include <list>
#include <map>
#include <string>
using namespace std;

namespace raccoon {

  class message;

  bool pass_message(message& m);
  
  class message_passer {
  public:
    message_passer() {};
    virtual ~message_passer();
    void accept_message(message& msg);

    string text_msgs_to_string(bool release=true);

  protected:
    message* pop_message();
    void     put_back_in_mb(message* m) { mailbox.push_back(m); };
    int      mailbox_size() { return mailbox.size(); };
    bool     waiting_messages() { return !mailbox.empty(); };
    void     release_message(message* m);

  private:
    list<message*> mailbox;

  };

  class message {
  public:
    message(message_passer* msg_to, message_passer* msg_from) : 
      sndr(msg_from),recip(msg_to) {};
    message_passer* sender() { return sndr; };
    message_passer* recipient() { return recip; };
    void set_recipient(message_passer* nu_r) 
      { recip = nu_r; };

    virtual message* clone()=0;

    virtual string to_string()
      { return "<msg>"; };

  protected:

  private:
    message_passer* sndr;
    message_passer* recip;

  };

  class text_message : public message {
  public:
    text_message(message_passer* msg_to, message_passer* msg_from,string msg) 
      : message(msg_to,msg_from),payload(msg) {};
    text_message(text_message& source) : message(source) 
      { payload = source.get_payload(); };

    virtual message* clone() { return new text_message(*this); };
    string  get_payload() { return payload; };

    virtual string to_string()
      { return "<msg: \""+payload+"\">"; };

  private:
    string payload;

  };

  typedef map<string,list<message_passer*> > channel_map_t;

  class broadcast {
  public:
    broadcast() {};
      
    static string USER_CHANNEL;
    static void send(message& message, string channel);
    static void subscribe(message_passer* who, string channel);
    static void unsubscribe(message_passer* who, string channel);
    static void unsubscribe(message_passer* who);

    static broadcast default_bcast;

    string to_string();
    static string sdb() { return default_bcast.to_string(); };

  protected:
    void add_listener(message_passer* who, string channel) {
      channels[channel].push_back(who);
    };
    void remove_listener(message_passer* who);
    void remove_listener(message_passer* who,string channel);
    void send_out(message& msg, string channel);      

  private:
    channel_map_t channels;
    
  };

};

#endif
