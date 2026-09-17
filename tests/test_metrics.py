import sqlite3
def db():
 c=sqlite3.connect(":memory:")
 c.executescript("""
 create table events(user_id text,d text);
 insert into events values ('u1','2026-01-01'),('u1','2026-01-01'),('u2','2026-01-01'),('u1','2026-02-01');
 create table subs(user_id text,started text);
 insert into subs values ('u1','2026-01-01'),('u2','2026-01-15');
 create table pay(user_id text,paid text,amount real);
 insert into pay values ('u1','2026-01-10',10),('u2','2026-01-20',20),('u1','2026-02-10',10);
 """);return c
def test_dau():
 assert [x[1] for x in db().execute("select d,count(distinct user_id) from events group by d order by d")]==[2,1]
def test_month_one_retention():
 c=db()
 cohort={u:s[:7] for u,s in c.execute("select user_id,min(started) from subs group by user_id")}
 feb_users={u for u,d in c.execute("select distinct user_id,d from events") if d[:7]=="2026-02"}
 assert len(feb_users & set(cohort))/len(cohort)==0.5
def test_cohort_ltv():
 c=db()
 revenue=c.execute("select sum(amount) from pay").fetchone()[0]
 customers=c.execute("select count(distinct user_id) from subs").fetchone()[0]
 assert revenue/customers==20.0
