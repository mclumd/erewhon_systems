for file in xs_*.bm ; do
  mv $file `echo $file | sed -e 's/xs_\(.\).*_\(.\)/\240\1/'` 
done
for file in sm_*.bm ; do
  mv $file `echo $file | sed -e 's/sm_\(.\).*_\(.\)/\264\1/'` 
done
for file in s_*.bm ol_*.bm ; do
  mv $file `echo $file | sed -e 's/\(.\).*_\(.\)/\280\1/'` 
done
mkdir new
for file in *s.bm *o.bm ; do
  sed -e "s/ [^ ]*_\([a-z][a-z][a-z]\)/ `basename ${file} .bm`_\1/" $file > new/$file
done
mv new/* .
rmdir new
