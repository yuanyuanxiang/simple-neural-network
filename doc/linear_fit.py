import tensorflow as tf
import numpy as np

# tensorflow直线拟合的例子
# 输入数据，近似于 z = 2x + 3y
x_data = np.array([[1,   1,   2,   0,   1,   3],
                   [1,   2,   0,   2,   0,   1]], dtype=np.float32)
y_data = np.array([ 4.9, 8.1, 3.9, 6.0, 1.9, 8.9], dtype=np.float32)

# 构造一个线性模型 y = W*x + b
b = tf.Variable(tf.zeros([1]))
W = tf.Variable(tf.random_uniform([1, 2]))
y = tf.matmul(W, x_data) + b

# 最小化方差
loss = tf.reduce_mean(tf.square(y - y_data))
optimizer = tf.train.GradientDescentOptimizer(0.1)
train = optimizer.minimize(loss)

# 初始化变量
init = tf.global_variables_initializer()

# 启动图 (graph)
sess = tf.Session()
sess.run(init)

# 拟合直线
for step in range(1000):
    sess.run(train)
    if (step+1) % 100 == 0:
        print(step+1, sess.run(W), sess.run(b))

# 得到最佳拟合结果 W: [1.9884607 3.0692296], b: [-0.10384388]
