#!/bin/bash

fail=0;


# Test 1: check alt's
#
# This would be easier if hxremove 7.9 would have been released already.
# What we're looking for is <a> without text or with images only whose alt text
# is empty.
#
# We wouldn't need the while/hxselect mess if we could do hxremove img[alt=""],
# but this segfaults in 7.8.
#
# What I'm doing here is:
# - cleaning up newlines
# - fetching every link
# - appending the alt text of any images in <a> bodies
# - remove the images from <a> bodies
# - if what's left has any text, it should be ok
if curl -L https://www.siac.vet |
		hxclean |
		tr '\n' ' ' |
		hxselect -c -s '\n' 'a[href="https://siac.vet"]' |
		while IFS= read line; do
			echo "$line $(echo "$line" | hxselect -c 'img::attr(alt)')";
		done |
		hxremove 'img' |
		grep "^\s*$" > /dev/null; then
	echo "failed on the alts check";
	fail=1;
fi

# Test 2: check G1: Add a link at the top of each page to directly access the main content area
#
# This isn't a great test we're writting, but it at least validates if the first link points to an anchor somewhere:
if [ "$(curl -L https://www.siac.vet | hxclean |hxselect a|head -n1|sed -n 's/.*href="\([^"]*\).*/\1/p'|grep -c \#)" = 0 ]; then
	echo "failed on the G1 check";
	fail=2;
fi

if [ "$fail" = 0 ]; then
	echo "siac: incumprimento pode já não existir";
else
	echo "siac: Incumprimento mantém-se, a actualizar o README (faça um git diff, valide, e commit!)";
	while IFS='' read -r line || [[ -n "$line" ]]; do
		test "$(echo "$line"|grep -v -c "siac")" -eq "1" \
			&& echo "$line" \
			|| (h=$(echo "$line"|cut -d\| -f1-4); t=$(echo "$line"|cut -d\| -f6-); echo "$h| $(date +%Y/%m/%d) |$t");
	done < README.md > new
	mv new README.md
fi
