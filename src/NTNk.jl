__precompile__()

"""
NTNk.jl: Nonnegative Tensor Networks based on NMFk.jl and NTFk.jl
----

**NMFk** performs unsupervised machine learning based on matrix decomposition coupled with sparsity and nonnegativity constraints.

**NMFk** methodology allows for automatic identification of the optimal number of features (signals) present in two-dimensional data arrays (matrices).

The number of features is estimated automatically.

**NTFk** performs unsupervised machine learning based on tensor decomposition coupled with sparsity and nonnegativity constraints.

**NTFk** methodology allows for automatic identification of the optimal number of features (signals) present in multi-dimensional data arrays (tensors).

The number of features (tensor \"rank\") along different dimensions can be estimated jointly and independently.

"""
module NTNk

import NMFk
import NTFk

const ntnkdir = splitdir(splitdir(pathof(NTNk))[1])[1]

"Test NTNk functions"
function test()
	include(joinpath(ntnkdir, "test", "runtests.jl"))
end

function welcome()
	c = Base.text_colors
	tx = c[:normal] # text
	bl = c[:bold] # bold
	d1 = c[:bold] * c[:blue]    # first dot
	d2 = c[:bold] * c[:red]     # second dot
	d3 = c[:bold] * c[:green]   # third dot
	d4 = c[:bold] * c[:magenta] # fourth dot
	println("$(bl)NTNk.jl: Nonnegative Tensor Networks based on NMFk.jl and NTFk.jl$(tx)")
	println("====")
	println("")
	println("$(d1)  _     _  $(d2) _________   $(d3)_     _   $(d4)_$(tx)")
	println("$(d1) |  \\  | | $(d2)|___   ___| $(d3)|  \\  | | $(d4)| |  _$(tx)")
	println("$(d1) | . \\ | |     $(d2)| |     $(d3)| . \\ | | $(d4)| | / /$(tx)")
	println("$(d1) | |\\ \\| |     $(d2)| |     $(d3)| |\\ \\| | $(d4)| |/ /$(tx)")
	println("$(d1) | | \\ ' |     $(d2)| |     $(d3)| | \\ ' | $(d4)|   ($(tx)")
	println("$(d1) | |  \\  |     $(d2)| |     $(d3)| |  \\  | $(d4)| |\\ \\$(tx)")
	println("$(d1) |_|   \\_|     $(d2)|_|     $(d3)|_|   \\_| $(d4)|_| \\_\\$(tx)")
	println("")
end

include("NTNkExecute.jl")

NTNk.welcome()

end