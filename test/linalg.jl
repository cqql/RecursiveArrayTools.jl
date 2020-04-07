using RecursiveArrayTools, Test, Random

n, m = 5, 6
bb = rand(n), rand(m)
b = ArrayPartition(bb)
@test Array(b) == collect(b) == vcat(bb...)
A = randn(MersenneTwister(123), n+m, n+m)

for ff in (lu, svd, qr)
    FF = ff(A)
    @test A*(FF \ b) ≈ b
    bbb = copy(b)
    @test ldiv!(bbb, FF, b) === bbb
    copyto!(bbb, b)
    @test ldiv!(FF, bbb) === bbb
    @test A*bbb ≈ b
end
