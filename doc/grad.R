# 拟合z=2x+3y
# 梯度下降法
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

# 学习率和学习次数
alpha = 0.01
step = 1000
# 初值
x = matrix(c(1,1,1), 3)
a = diag(rep(1, 3)) - alpha * t_m %*% m

for (i in 1:step){
  x = a %*% x + alpha * t_m %*% y
}

print(x)