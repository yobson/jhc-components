CABAL_FLAGS=

.PHONEY: all
all :
	cabal run $(CABAL_FLAGS) jhc -- --help

.PHONEY: stdlib
stdlib : all
	cabal run $(CABAL_FLAGS) jhc -- -L . --build-hl  lib/jhc-prim/jhc-prim.yaml
	cabal run $(CABAL_FLAGS) jhc -- -L . --build-hl  lib/jhc/jhc.yaml
	cabal run $(CABAL_FLAGS) jhc -- -L . --build-hl  lib/haskell-extras/haskell-extras.yaml
	cabal run $(CABAL_FLAGS) jhc -- -L . --build-hl  lib/haskell2010/haskell2010.yaml
	cabal run $(CABAL_FLAGS) jhc -- -L . --build-hl  lib/haskell98/haskell98.yaml
	cabal run $(CABAL_FLAGS) jhc -- -L . --build-hl  lib/applicative/applicative.yaml
	cabal run $(CABAL_FLAGS) jhc -- -L . --build-hl  lib/flat-foreign/flat-foreign.yaml

.PHONEY: examples
examples : stdlib
	cabal run $(CABAL_FLAGS) jhc -- -L . examples/Calendar.hs -o calendar
	cabal run $(CABAL_FLAGS) jhc -- -L . examples/HelloWorld.hs -o hello
	cabal run $(CABAL_FLAGS) jhc -- -L . examples/Primes.hs -o primes

.PHONEY: jhc-stack
jhc-stack:
	stack build

.PHONEY: stdlib-stack
stdlib-stack : jhc-stack
	stack exec jhc -- -L . --build-hl  lib/jhc-prim/jhc-prim.yaml
	stack exec jhc -- -L . --build-hl  lib/jhc/jhc.yaml
	stack exec jhc -- -L . --build-hl  lib/haskell-extras/haskell-extras.yaml
	stack exec jhc -- -L . --build-hl  lib/haskell2010/haskell2010.yaml
	stack exec jhc -- -L . --build-hl  lib/haskell98/haskell98.yaml
	stack exec jhc -- -L . --build-hl  lib/applicative/applicative.yaml
	stack exec jhc -- -L . --build-hl  lib/flat-foreign/flat-foreign.yaml

.PHONEY: examples-stack
examples-stack : stdlib-stack
	stack exec jhc -- -L . examples/Calendar.hs -o calendar
	stack exec jhc -- -L . examples/HelloWorld.hs -o hello
	stack exec jhc -- -L . examples/Primes.hs -o primes
