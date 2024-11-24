function [y, bcc] = chaos_game(n_points, opt)
%{
CHAOS_GAME generates Sierpinski triangle using a chaos game.

Input argument:
    n_points : number of point being generated during chaos game

Name-Value arguments:
    RandomStream - random stream which is used for choosing random quantities of the game.
        The default value is global stream.
    Vertices - Cartersian coordinates of three vertices of the outer triangles.
        The default vertices is (-0.5, 0.0), (+0.5, 0.0), and (0.0, sqrt(3)/2).

Output arguments:
    y - coordinates of the points forming the Sierpinski triangles.
        Its size is (N_POINTS + 3) x 3.
    bbc  - barycentric coordinates of the Y.
        Its size is (N_POINTS + 3) x 2.

Reference:
    [1] Feldman, David P., 
        Chaos and Fractals: An Elementary Introduction, Section 17.4, 
        Oxford, 2012; online edn, Oxford Academic, 17 Dec. 2013,
        https://doi.org/10.1093/acprof:oso/9780199566433.001.0001
%}
    arguments
        n_points {mustBeInteger, mustBePositive, mustBeScalarOrEmpty} = 100
        opt.RandomStream = RandStream.getGlobalStream
        opt.Vertices (3, 2) double {mustBeNumeric} = [-0.5, 0.0; +0.5, 0.0; 0.0, sqrt(3)/2.0]
    end
    n_vertices = 3;
    vertex_bcc = [1, 0, 0; 0 1 0; 0 0 1];
    point_bcc = zeros([n_vertices  +  n_points, 3]);
    point_bcc(1:3, :) = vertex_bcc;

    rnd_strm = opt.RandomStream;
    t = zeros([1, 3]);
    t(1:2) = rand(rnd_strm, 1, 2) / 2.0;
    t(3) = 1.0 - sum(t(1:2));
    i_point = 4;
    point_bcc(i_point, :) =  vertex_bcc * t';
    for ii = 2 : n_points
        i_point = n_vertices + ii;
        i_vert = randi(rnd_strm, n_vertices);
        j_point = i_point - 1;
        point_bcc(i_point, :) = (point_bcc(j_point, :) + point_bcc(i_vert, :)) / 2.0;
    end

    y = point_bcc * opt.Vertices;
    if nargout > 1
        bcc = point_bcc;
    end
end
