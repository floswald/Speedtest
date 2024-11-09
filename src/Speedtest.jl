module Speedtest

using JSON
using JLD2


function run_test()

    if isnothing(Sys.which("speedtest"))
        error("you must install the speedtest CLI from https://www.speedtest.net/apps/cli")
    end

    jld = joinpath(@__DIR__,"..","timings.jld2")

    @info "running test"

    r = JSON.parse(read(`speedtest -f json`, String))

    jldopen(jld, "w") do f
        f[r["timestamp"]] = r
    end

    @info "done"
    
    return r 
end

end