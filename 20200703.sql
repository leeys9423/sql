실습 join1
SELECT lprod.lprod_gu, lprod_nm, prod_id, prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;

SELECT lprod.lprod_gu, lprod_nm, prod_id, prod_name
FROM prod JOIN lprod ON (prod.prod_lgu = lprod.lprod_gu);

실습 join2
SELECT prod.prod_buyer, buyer_name, prod_id, prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;

SELECT prod.prod_buyer, buyer_name, prod_id, prod_name
FROM prod JOIN buyer ON (prod.prod_buyer = buyer.buyer_id);

실습 join3
SELECT a.mem_id, a.mem_name, prod.prod_id, prod_name, a.cart_qty
FROM (SELECT member.mem_id, mem_name, cart_qty, cart_prod
FROM member JOIN cart ON (mem_id = cart.cart_member)) a JOIN prod ON (a.cart_prod = prod.prod_id);

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart ON ( member.mem_id = cart.cart_member )
            JOIN prod ON ( cart.cart_prod = prod.prod_id);

SELECT member.mem_id, mem_name, prod.prod_id, prod_name, cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member AND cart.cart_prod = prod.prod_id;

CUSTMOER : 고객
PRODUCT : 제품
CYCLE : 고객 제품 애음 주기
SELECT *
FROM product;

실습4
SELECT customer.cid, cnm, pid, day, cnt
FROM  customer, cycle
WHERE customer.cid = cycle.cid
      AND (customer.cid = 1 OR customer.cid = 2);
and 연산이 우선순위 이므로 or 절을 ()처리 안해주면 다른값이 나옴

SELECT customer.cid, cnm, pid, day, cnt
FROM customer JOIN cycle ON ( customer.cid = cycle.cid )
WHERE customer.cid=1 OR customer.cid=2;

실습5
SELECT cid, cnm, pid, pnm, day, cnt
FROM customer JOIN cycle USING (cid)
              JOIN product USING (pid)
WHERE cid=1 OR cid=2;

SELECT customer.cid, cnm, cycle.pid, pnm, day, cnt
FROM  customer, cycle, product
WHERE customer.cid = cycle.cid
      AND cycle.pid = product.pid
      AND (customer.cid = 1 OR customer.cid = 2);

실습6
SELECT a.cid, cnm, product.pid, pnm, a.cnt
FROM
(SELECT cid, pid, SUM(cnt) cnt
 FROM cycle
 GROUP BY cid, pid) a, customer, product
WHERE customer.cid = a.cid
      AND a.pid = product.pid;
      
SELECT customer.*, cycle.pid, pnm, SUM(cnt)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid
GROUP BY customer.cid, customer.cnm, cycle.pid, pnm;
      
실습7
SELECT a.pid, pnm, a.cnt
FROM
(SELECT pid, SUM(cnt) cnt
 FROM cycle
 GROUP BY pid) a, product
 WHERE a.pid = product.pid;
 
SELECT cycle.pid, pnm, SUM(cnt)
FROM cycle, product
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, pnm;


조인 성공 여부로 데이터 조회를 결정하는 구분방법
INNER JOIN : 조인에 성공하는 데이터만 조회하는 조인 방법
OUTER JOIN : 조인에 실패 하더라도, 개발자가 지정한 기준이 되는 테이블의 데이터는 나오도록 하는 조인
OUTER <==> INNER JOIN

복습 - 사원의 관리자 이름을 알고싶은 상황
      조회 컬럼 : 사원의 사번, 사원의 이름, 사원의 관리자의 사번, 사원의 관리자의 이름
동일한 테이블끼리 조인 되었기 때문에 : SELF=JOIN
조인 조건을 만족하는 데이터만 조회 되었기 때문에 : INNER-JOIN
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

KING의 경우 PRESIDENT이기 때문에 mgr 컬럼의 값이 NULL ==> 조인에 실패
==> KING의 데이터는 조회되지 않음 (총 14건 데이터 중 13건의 데이터만 조인 성공)

OUTER 조인을 이용하여 조인 테이블중 기준이 되는 테이블을 선택하면
조인에 실패하더라도 기준 테이블의 데이터는 조회 되도록 할 수 있다.
LEFT / RIGHT OUTER
ANSI-SQL
테이블1 JOIN 테이블2 ON(....)
테이블1 LEFT OUTER JOIN 테이블2 ON(....)
위 쿼리는 아래와 동일
테이블2 RIGHT OUTER JOIN 테이블1 ON(....)


SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m. empno);

SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m. empno);