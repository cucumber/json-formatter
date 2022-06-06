default:
	cd testdata && make
	cd go && make

clean:
	cd testdata && make clean
	cd go && make clean

.PHONY: default clean
