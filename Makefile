default: Resume.html
	open -a Safari Resume.html
	$(info <<< Save Safari resume to PDF if needed)

%.html: %.elm
	elm make $^ --output=$@

all: default HomePage.html
	mv HomePage.html index.html
	git add .
	git commit -m $(COMMIT)
	git push

