index.html: index.md Makefile
	pandoc --standalone --mathjax --toc -o index.html index.md


.PHONY: /tmp/cnw-2014.zip clean

/tmp/cnw-2014.zip:
	rm -fr /tmp/cnw-2014.zip
	cd ..; zip -r /tmp/cnw-2014.zip cnw-2014
	chmod o+r /tmp/cnw-2014.zip
	scp /tmp/cnw-2014.zip sje30@rgc:web/


clean:
	rm -f *~
