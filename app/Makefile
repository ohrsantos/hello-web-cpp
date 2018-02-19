LIBS=-lcppcms -lbooster


all: app

app: app.cpp
	$(CXX) -O2 -Wall -g app.cpp -o app ${LIBS}

clean:
	rm -fr app cppcms_rundir
