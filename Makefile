main:
	gem build vll.gemspec && gem push *.gem && rm *.gem && git add -A . && git commit -am 'commit' && git push origin master

