module NTNk

import NMFk
import NTFk

const ntnkdir = splitdir(splitdir(pathof(NTNk))[1])[1]

"Test NTNk functions"
function test()
	include(joinpath(ntnkdir, "test", "runtests.jl"))
end

include("NTNkExecute.jl")

end