---
title: "Century Bar"
tag:
- aws
- lambda
- python
- twitter
- century
- github
- date
- time
- datetime
date: 2019-04-06T12:23:12+02:00
---
There's this very cool Twitter account called [@year_progress](https://twitter.com/year_progress) that tweets every time the year has elapsed 1%. The author, [Filip Hráček](https://filiph.net/) has built other counters in his [progress bar page](https://progressbarserver.appspot.com/), mainly to keep track of the current quarter, month and workday. Overall a pretty intersting hack.

Inspired by that hack and based on the fact that I wanted to try out some of the [AWS Lambda features](https://aws.amazon.com/lambda/), I started to think about how to calculate the progress of the entire 21st century. Given we are in 2019, assumption would be that we are roughly 19% in so far of the century. Then I started obsessing about it a little bit thinking on ways to calculate it. At the end, I learned a whole bunch about time calculation on a very long timespan. For instance, the fact that we have leap years makes the calculation far far interesting. A naive approach would be to think that every year elapsed will mean that 1% of the century has occured. And not really, since the leap years will unbalance that out:

```
>>> from datetime import datetime, date, time
>>> start = datetime(2001, 1, 1, 0, 0, 0)
>>> end   = datetime(2100, 12, 31, 23, 59, 59)
>>> (end - start).total_seconds()
3155673599.0
```
Those are a lot of seconds in a whole century, isn't it.

So if we split all of those seconds into 100, to get 1%, we don't necessarily end up by the end of 2001 or early beginning of 2002:
```
>>> (end - start).total_seconds() / 100
31556735.99
>>> start + timedelta(0, 31556735.99)
datetime.datetime(2002, 1, 1, 5, 45, 35, 990000)
```

We are actually 5 hours and 45 minutes into the new year: 5h 45m 35s to be exact. On the other end, we are logically roughly the same distance away:

```
>>> start + timedelta(0, 31556735.99 * 99)
datetime.datetime(2099, 12, 31, 18, 14, 23, 10000)i
```

So when this year comes to an end, we won't really be at 19% elapsed sharp:

```
>>> end_2019 = datetime(2019, 12, 31, 23, 59, 59)
>>> full = end - start
>>> ( ( end_2019 - start).total_seconds() / full.total_seconds() ) * 100
18.998466735912885
```

Go follow [@century_bar](https://twitter.com/century_bar) for more of this fun. A bit more of the explanation is at the GitHub repo [here](https://github.com/damog/century-progress).

*dm*

