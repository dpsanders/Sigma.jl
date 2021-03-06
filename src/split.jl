## Splitting Strategies
## ====================

# This splits along all dimensions, ignores the depth
function weighted_mid_split(o::Omega{Float64}, depth::Int)
  splitted = mid_split(o::Omega{Float64})
  transitionprob = 1/length(splitted)
  [(event, transitionprob) for event in splitted]
end

# This splits along the 1st dimension in for the first split
# The second dimension for the second split, then cycles
function weighted_partial_split(o::Omega{Float64}, depth::Int)
  dimindices = collect(keys(o.intervals))
  ndims = length(dimindices)

  if (depth % length(dimindices)) + 1 > length(dimindices)
    @show depth
    @show dimindices
  end

  dimtosplit = dimindices[(depth % length(dimindices)) + 1]
  splitted = mid_partial_split(o::Omega{Float64}, [dimtosplit])
  transitionprob = 1/length(splitted)
  [(event, transitionprob) for event in splitted]
end

# Randomly select a dimension
function rand_partial_split(o::Omega{Float64}, depth::Int; ndims = 4)
  dimindices = collect(keys(o.intervals))
  randindices = unique([rand_select(dimindices) for i = 1:ndims])
  splitted = mid_partial_split(o::Omega{Float64}, randindices)
  transitionprob = 1/length(splitted)
  [(event, transitionprob) for event in splitted]
end