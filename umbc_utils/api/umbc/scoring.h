#ifndef SCORING_H
#define SCORING_H

#include <string>
#include <map>
using namespace std;

namespace umbc {

  class scoring_system {
  public:
    scoring_system() : filename(default_filename()),score(0.0) { write_hdr(); };
    scoring_system(string fname) : filename(filename),score(0.0) 
      { write_hdr(); };
    virtual ~scoring_system() {};
    
    virtual void update_score()=0;
    virtual void write_score();
    virtual double get_score() { return score; };
    
    virtual void update() { update_score(); write_score(); };
    
    static string default_filename();
    
  protected:
    string filename;
    double score;
    void write_hdr();
  };
  
  class decl_based_scorer : public scoring_system {
  public:
    decl_based_scorer() : scoring_system() {};
    decl_based_scorer(string fn) : scoring_system(fn) {};
    virtual ~decl_based_scorer() {};
    
    void add_scoring_rule(string desc, double mul) { scoremap[desc]=mul; }
    
    virtual void update_score();
    
  protected:
    map<string,double> scoremap;
    
  };
  
};
#endif
