classdef ChaosGame_Test < matlab.unittest.TestCase
methods (Test)
    function check_code_problem(tst)
        m_filename = "chaos_game.m";
        code_problems = checkcode(m_filename, "-string");
        tst.verifyTrue(isempty(code_problems));
        if ~isempty(code_problems)
            disp(code_problems);
        end
    end

    function check_point_distribution(tst)
        for seed = 1 : 10
            rnd_strm = RandStream("mt19937ar", Seed = seed);
            n_points = randi(rnd_strm, [1e+2, 1e+5]);
            [~, bcc] = chaos_game(n_points);
            inds = find(bcc(5:end, 1) <= 0.5 & bcc(5:end, 2) <= 0.5 & bcc(5:end, 3) <= 0.5);
            if ~isempty(inds)
                fprintf("Seed id.: %d", seed);
                disp(inds);
            end
            tst.verifyTrue(isempty(inds));

            ids = find(bcc > 1.0 & bcc < 0.0); %#ok<EFIND>
            tst.verifyTrue(isempty(ids));
        end
    end

    function check_output_size(tst)
        n_points = 1e+3;
        [y, bcc] = chaos_game(n_points);
        tst.verifyTrue(isequal(size(y), [n_points + 3, 2]));
        tst.verifyTrue(isequal(size(bcc), [n_points + 3, 3]));
    end
end
end
