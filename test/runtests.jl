import NTNk
import Test
import Random

@Test.testset "Hierarchical Tucker analysis" begin
	Random.seed!(1)
	X = rand(20, 20, 20)
	Xl, sl = NTNk.execute(X, 3)
	@Test.test size(Xl[1]) == (20, 20, 20)
	@Test.test sl[1] == (20, 20, 20)
end

@Test.testset "Tensor Train analysis" begin
	Random.seed!(1)
	X = rand(20, 20, 20)
	Wl, G, sz = NTNk.execute(X, [3, 3, 3])
	@Test.test size(Wl[1]) == (20, 3)
	@Test.test size(Wl[2]) == (20, 3)
	@Test.test size(Wl[3]) == (20, 3)
	@Test.test size(G) == (3, 3, 3)
	@Test.test sz == [3, 3, 3]
end