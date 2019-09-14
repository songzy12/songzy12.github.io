---
layout: post
title: "matplotlib"
date: 2016-11-05 16:46:28 +0800
comments: true
categories: 

---

```
_tkinter.TclError: no display name and no $DISPLAY environment variable
```

```
import matplotlib
matplotlib.use('Agg')
```

## pyplot

```
from matplotlib import pyplot as plt
plt.scatter(x, y, c) # color
plt.plot(x, y)
plt.xlabel('x')
plt.ylabel('y')
plt.savefig(image_name)
plt.clf() # clear the figure
plt.bar(x, y, align='center')
plt.show()
```

## pylab

```
from matplotlib import pylab

pylab.xlabel("Sentence Gap index")
pylab.ylabel("Gap Scores")
pylab.plot(range(len(s)), s, label="Gap Scores")
pylab.plot(range(len(ss)), ss, label="Smoothed Gap scores")
pylab.plot(range(len(d)), d, label="Depth scores")
pylab.stem(range(len(b)), b)
pylab.legend()
fname = 'image.png'
pylab.savefig(fname)
```

## subplot, pie

```
fig = plt.figure()
ax = fig.add_subplot(111)
ax.plot(centers[2], color='#00BFFF', label='1')
ax.plot(centers[4], color='#BA55D3', label='2')
ax.plot(centers[1], color='g', label='3')
ax.plot(centers[3], color='b', linewidth=3, label='4')
ax.plot(centers[0], color='r', linewidth=3, label='5')
plt.xlabel('Jump span (in second)')
plt.ylabel('Probability')

ax.legend()
# plt.title('User Preference Clustering by Jump Span')
x1, x2, y1, y2 = plt.axis()
plt.axis([x1, x2, 0, y2])

# pie chart
fracs = [np.count_nonzero(labels==2), np.count_nonzero(labels==4), np.count_nonzero(labels==1), np.count_nonzero(labels==3), np.count_nonzero(labels==0)]
colors = ['#00BFFF', '#BA55D3', 'g', 'b', 'r']
explode=(0, 0.05, 0, 0, 0)

ax1 = fig.add_subplot(3, 3, 2)
ax1.set_position([0.5,0.6,0.3,0.3])
ax1.axis('equal')
patches, texts, autotexts = ax1.pie(fracs, colors=colors, autopct='%1.1f%%')
print autotexts
for patch, txt in zip(patches, autotexts):
    # the angle at which the text is located
    ang = (patch.theta2 + patch.theta1) / 2.
    # new coordinates of the text, 0.7 is the distance from the center 
    x = patch.r * 1.3 * np.cos(ang*np.pi/180)
    y = patch.r * 1.3 * np.sin(ang*np.pi/180)
    # if patch is narrow enough, move text to new coordinates
    print patch.theta2 - patch.theta1
    if (patch.theta2 - patch.theta1) < 30.:
        txt.set_position((x, y))
```

## grid

```
import matplotlib.pyplot as plt
import matplotlib.ticker as plticker

data = [50 * random.random() for i in range(20)]

x = range(len(data))

fig = plt.figure()
axes = plt.gca()
axes.set_xlim([0, 20])

ax = fig.add_subplot(1, 1, 1)
major_ticks = range(0, 20, 2)
minor_ticks = range(0, 50, 5)
ax.set_xticks(major_ticks)

ax.grid(which='both')

plt.scatter(x, data)
# plt.grid()

plt.xlabel('Users')
plt.ylabel('Average jump span')
#plt.savefig('user_jump_span.png')
plt.show()
```
