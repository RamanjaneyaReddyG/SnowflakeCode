create database data_lake;

--drop database datalake;

--


ALTER USER RAMANJASPER3
    SET RSA_PUBLIC_KEY = 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyEVfcBMw76ZjSCDeh/o4
tpBbuLiT9dJFzVYUhZPgxKSxaZdOMcBVJKCV8bjIKOCxCR7gPbaiHax1KaI0OQMc
ki7Tr3HFJ5m2n5nQ31LtbI7RDQH3QmV6LwaaX/c2nI3dZ0L6Bck+jf1X6ZFZPUzt
8P/ekgCVY8CU0lS8LIcGRiRmd3J2TF2I7FmV6uF9DHeEQiRAsm0nWjTXzHPdVu4b
5JrrppenuUkJ+rm4DPlwNdbwwkI/9FdqfWG1p0Tg1mujTn562sPYGdrOmN1eFNIU
FH/vXlqMIImsv02U6ojkGk9xOjjVvyJeWtWiqx+w6ewnNsLiKX67u3ofZbY+wX7F
zwIDAQAB';

create role fivetran_role;

grant role fivetran_role to user RAMANJASPER3;

select * from employees;



