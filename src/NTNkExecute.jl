
"""
Hierarchical Tucker
"""
function execute(X::AbstractArray{T,N}, nlevels::Integer=10; csizes::Vector{NTuple{N,Int}}=[size(X)], nTF::Integer=1, eigmethod=ntuple(i->false, length(csizes[1])), prefix="", kw...) where {T,N}
	Xl = Vector{Array{T,N}}(undef, nlevels)
	sl = Vector{typeof(csizes[1])}(undef, nlevels)
	local X1
	for i = 1:nlevels
		@info("Hierarchical Tucker Level $i")
		if i == 1
			t, sizes, ibest = NTFk.analysis(X, csizes, nTF; eigmethod=eigmethod, prefix=prefix, kw...)
			@info("Hierarchical Tucker Level $i core size: $sizes")
			Xl[i] = NTFk.compose(t[ibest])
			X1 = X .- Xl[i]
		else
			t, sizes, ibest = NTFk.analysis(X1, csizes, nTF; eigmethod=eigmethod, prefix=prefix, kw...)
			@info("Hierarchical Tucker Level $i core size: $sizes")
			Xl[i] = NTFk.compose(t[ibest])
			X1 .-= Xl[i]
		end
		sl[i] = sizes
		if sizes == ntuple(i->1, length(sizes)) || sizes == ntuple(i->0, length(sizes))
			@info("Hierarchical Tucker done: $sizes reached!")
			return Xl, sl
		end
	end
	return Xl, sl
end

"""
Tensor Train
"""
function execute(X::AbstractArray{T,N}, nk::Vector{Int}; order::AbstractRange=1:N, save::Bool=false, kw...) where {T,N}
	sz = collect(size(X))
	Wl = Vector{Matrix{T}}(undef, N)
	local X1
	for (e, i) = enumerate(order)
		@info("Tensor Train Dimension $i")
		if i == 1
			Xu = NTFk.unfold(X, i)
		else
			Xu = NTFk.unfold(X1, i)
		end
		W, M, phi, sil, aic = NMFk.execute(Xu, nk[e]; save=save)
		sz[e] = nk[e]
		Wl[i] = W
		X1 = NTFk.fold(M, i, sz)
	end
	return Wl, X1, sz
end