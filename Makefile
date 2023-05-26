.PHONY: wishing_star meteor wishmaker clean

all: wishing_star meteor wishmaker

wishing_star:
	@armips wishing_star.s
	@mkdir -p out
	@flips -c sample0519.bin sample0519.patched.bin out/sample0519.ips
	# @rm sample0519.patched.bin

meteor:
	@armips meteor.s
	@mkdir -p out
	@flips -c client.2003_1112.bin client.2003_1112.patched.bin out/client.2003_1112.ips
	@rm client.2003_1112.patched.bin

wishmaker:
	@armips wishmaker.s
	@mkdir -p out
	@flips -c client.bin client.patched.bin out/client.ips
	@rm client.patched.bin

clean:
	@rm -rf *.patched.bin out
