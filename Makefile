.PHONY: wishing_star meteor wishmaker clean

all: wishing_star meteor wishmaker

wishing_star:
	@mkdir -p build/other build/mgba out/other out/mgba
	@armips wishing_star.s -equ COMPRESSED_IN_ADDR 0x8000278 -strequ OUT_FILE "build/other/sample0519.patched.bin"
	@armips wishing_star.s -equ COMPRESSED_IN_ADDR 0x2000278 -strequ OUT_FILE "build/mgba/sample0519.patched.bin"
	@flips -c sample0519.bin build/other/sample0519.patched.bin out/other/sample0519.ips
	@flips -c sample0519.bin build/mgba/sample0519.patched.bin out/mgba/sample0519.ips

meteor:
	@mkdir -p build/other build/mgba out/other out/mgba
	@armips meteor.s -equ COMPRESSED_IN_ADDR 0x8000278 -strequ OUT_FILE "build/other/client.2003_1112.patched.bin"
	@armips meteor.s  -equ COMPRESSED_IN_ADDR 0x2000278 -strequ OUT_FILE "build/mgba/client.2003_1112.patched.bin"
	@flips -c client.2003_1112.bin build/other/client.2003_1112.patched.bin out/other/client.2003_1112.ips
	@flips -c client.2003_1112.bin build/mgba/client.2003_1112.patched.bin out/mgba/client.2003_1112.ips

wishmaker:
	@mkdir -p build/other build/mgba out/other out/mgba
	@armips wishmaker.s -equ COMPRESSED_IN_ADDR 0x8000278 -strequ OUT_FILE "build/other/client.patched.bin"
	@armips wishmaker.s -equ COMPRESSED_IN_ADDR 0x2000278 -strequ OUT_FILE "build/mgba/client.patched.bin"
	@flips -c client.bin build/other/client.patched.bin out/other/client.ips
	@flips -c client.bin build/mgba/client.patched.bin out/mgba/client.ips

clean:
	@rm -rf build out
