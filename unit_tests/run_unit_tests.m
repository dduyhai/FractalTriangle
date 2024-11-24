function run_unit_tests()
    addpath("../src/");
    test_suites = testsuite("ChaosGame_Test");
    results = run(test_suites);
    disp(results.table);
end
