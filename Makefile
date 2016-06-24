DUTI_VERSION=1.7

CFLAGS=-g -O2 -Wall \
			 -isysroot $(shell xcrun --show-sdk-path) \
			 -mmacosx-version-min=10.9 \
			 -DDUTI_VERSION='"${DUTI_VERSION}"'
FRAMEWORKS=-framework ApplicationServices -framework CoreFoundation

PB_ARGS=--ownership preserve --quiet

BINDIR=/usr/local/bin
MANDIR=/usr/local/share/man/man1

all: duti duti.1

duti: duti.o handler.o plist.o util.o
	@echo "[LD] ${@}"
	@${CC} ${CFLAGS} ${FRAMEWORKS} -o $@ $^

%.o: %.c
	@echo "[CC] ${@}"
	@${CC} ${CFLAGS} -c ${<}

install: all
	@-mkdir -p ${BINDIR}
	@-mkdir -p ${MANDIR}
	install -m 0755 -c duti ${BINDIR}
	install -m 0644 -c duti.1 ${MANDIR}
	@sed -i '' -e 's@_DUTI_BUILD_DATE@$(shell date '+%B %d, %Y')@g' ${MANDIR}/duti.1

pkg: package
package: all
	@mkdir -p -m 0755 pkg/${BINDIR} pkg/${MANDIR}
	@install -m 0755 -c duti pkg/${BINDIR}
	@install -m 0644 -c duti.1 pkg/${MANDIR}
	@sed -i '' -e 's@_DUTI_BUILD_DATE@$(shell date '+%B %d, %Y')@g' pkg/${MANDIR}/duti.1
	@sudo chown -R root:wheel pkg
	/usr/bin/pkgbuild \
		${PB_ARGS} \
		--root pkg \
		--identifier public-domain.mortensen.duti-installer \
		--version ${DUTI_VERSION} \
		duti-${DUTI_VERSION}.pkg
	@sudo rm -rf pkg

clean:
	rm -f *.o
	rm -f duti
	rm -f duti-*.pkg
