#Copyright (c) Microsoft. All rights reserved.
#Licensed under the MIT license. See LICENSE file in the project root for full license information.

set(ctest_ut_c_files
	assertfailurestests.c
	assertsuccesstests.c
	ctestunittests.c
	simpletestsuiteonetest.c
	simpletestsuitetwotests.c
	testfunctioncleanuptests.c
	testfunctioninitializetests.c
	testsuiteinitializecleanuptests.c
	whentestsuiteinitializefailstests.c
	whentestfunctioninitializefailstests.c
	testfunctioncleanupfailstests.c)

set(ctest_ut_cpp_files
	simpletestsuiteonetestcpp.cpp)

set(ctest_ut_h_files)

add_executable(ctest_ut
	${ctest_ut_c_files} ${ctest_ut_cpp_files} ${ctest_ut_h_files})

set_target_properties(ctest_ut PROPERTIES FOLDER "tests/ctest_ut")
			   
target_link_libraries(ctest_ut ctest)

add_test(NAME ctest_ut COMMAND ctest_ut)
