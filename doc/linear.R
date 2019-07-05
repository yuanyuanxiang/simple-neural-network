# 拟合z=2x+3y
# 直接解法
m<-matrix(nrow=6, ncol=3)
m[1,]=c(1, 1, 1)
m[2,]=c(1, 1, 2)
m[3,]=c(1, 2, 0)
m[4,]=c(1, 0, 2)
m[5,]=c(1, 1, 0)
m[6,]=c(1, 3, 1)
y<-matrix(nrow=6, ncol=1)
y[,1]=c(4.9, 8.1, 3.9, 6, 1.9, 8.9)
t_m=t(m)

x=solve(t_m%*%m)%*%t_m%*%y
print(x)