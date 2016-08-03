import os, sys, subprocess

DEFAULT_OUT = "plans"

#used for an earlier (and worse) implementation. Left in just in case.
def add_prefix(filename, prefix):
	f = open(filename,'r')
	temp = f.read()
	f.close()
	newtxt = prefix + temp
	f = open(filename, 'w')
	f.write(newtxt)
	f.close()

def run_shop2(domainfile, problemfile, outputfile):
	#change path to SHOP2 dir to avoid problems with run.
	oldpath = os.getcwd()
	problemfile = oldpath + "/" + problemfile
	outputfile = oldpath + "/" + outputfile
	#print outputfile
	abspath = os.path.abspath(__file__)
	dname = os.path.dirname(abspath)
	os.chdir(dname)
	
	#run shop2
	shop2 = subprocess.Popen(['/usr/local/allegrocommonlisp-8.2/alisp', '-#!', 'shop2-load.lisp', domainfile, problemfile, outputfile], stdout=subprocess.PIPE)
	shop2.wait()
	#print shop2.stdout.read() #uncomment to print shop2 output
	
	#return to previous dir
	os.chdir(oldpath)

if __name__ == "__main__":
	if len(sys.argv) == 4:
		run_shop2(sys.argv[1], sys.argv[2], sys.argv[3])
	elif len(sys.argv) == 3:
		run_shop2(sys.argv[1], sys.argv[2], DEFAULT_OUT)
	else:
		print "Usage: 'python runlisp.py domainfile problemfile outputfile [optional]'"
