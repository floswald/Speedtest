module Speedtest
using Dates
using DataFrames 
using CSV

function run_test()

    if isnothing(Sys.which("speedtest"))
        error("you must install the speedtest CLI from https://www.speedtest.net/apps/cli")
    end

    csv = joinpath(@__DIR__,"..","timings.csv")
    tmp,io = mktemp()

    t = now()   # time stamp
    # append to existing csv or create new
    if !isfile(csv)
    
        @info "first run - creating output csv"
        run(`speedtest -f csv  --output-header \> $tmp`)

        # read back and add time stamp
        d = CSV.read(tmp, DataFrame)
        d.timestamp .= t

        # write out 
        CSV.write(csv, d)

    else
        run(`speedtest -f csv  --output-header \> $tmp`)

        # read back and add time stamp
        d = CSV.read(tmp, DataFrame)
        d.timestamp .= t

        # write out 
        CSV.write(csv, d, append = true)
    end
end

end # module Speedtest
