This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

# ctest

azure-ctest (or just "ctest") is a simple portable C test runner. Tests written with ctest are built into standalone binaries that run from the command line.

## Build

```
git clone https://github.com/Azure/azure-ctest
cd azure-ctest
mkdir build
cd build
cmake ..
cmake --build .
```

## Run ctest's unit tests (optional)

```
cmake -DENABLE_UNIT_TESTS=ON ..
cmake --build .
ctest -C Debug # <- CMake's 'ctest' tool, which invokes our test binaries
```

## Install and Use
To take a dependency on ctest in your project, install it in your developer environment:

```
cmake --build . --target install
```

If your project uses CMake, refer to ctest in your CMakeLists.txt file as follows:

```
find_package(ctest REQUIRED CONFIG)
# ...
target_link_library(yourlib ctest)
```

## Write tests

```c
#include "ctest.h"

CTEST_BEGIN_TEST_SUITE(Suite1)

CTEST_FUNCTION(Test1)
{
    int x = some_function();
    CTEST_ASSERT_ARE_EQUAL(int, 42, x);
}

CTEST_END_TEST_SUITE(SimpleTestSuiteOneTest)
```
