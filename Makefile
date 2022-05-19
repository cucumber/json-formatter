default:
	cd ruby-testdata && make
	cd go && make

clean:
	cd ruby-testdata && make clean
	cd go && make clean

.PHONY: default clean
