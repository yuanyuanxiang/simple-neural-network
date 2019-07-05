A=matrix(nrow=4,ncol=4)
A[1,]=c(1,2,3,4)
A[2,]=c(2,2,3,4)
A[3,]=c(3,3,3,4)
A[4,]=c(4,4,4,4)
# QR分解
qr_r = qr(A)
q = qr.Q(qr_r)
r = qr.R(qr_r)
# SVD分解
svd_r = svd(A)
d = svd_r$d
u = svd_r$u
v = svd_r$v
