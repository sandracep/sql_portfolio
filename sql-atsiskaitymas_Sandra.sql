
-- Lentelės, kurių reiks: Benefits, Departments, EmployeeBenefits,
-- Employees, EmployeeSkills, JobPositions, LeaveRequests, Performacereviews,
-- Salaries, Skills.

-- Vertinimas:

-- Padarius pilnai užduotį už ją yra duodamas 1 balas. Išsprendus dalinai, arba neišsprendus taip kad matytųsi rezultatas bet pagal kodą keliauta į tą pusę - skiriama 0.5 balo. Neišsprendus arba ėjus į visiškai ne tą pusę su sprendimu - skiriama 0 balo.
-- Surinkus iš viso 20 balų ar daugiau - pažymys gaunasi 10. Surinkus mažiau - proporciškai pažymys mažėja.

-- 1. Pasirinkite visus darbuotojus: parašykite SQL užklausą, kuri gautų
-- visus darbuotojų įrašus iš Employees lentelės. (TIP: turi būti išvesta visa
-- visų darbuotojų informacija)

select * from employees;

-- 2. Pasirinkite tam tikrus stulpelius: parodykite visus vardus ir
-- pavardes iš Employees lentelės. (TIP: turi matytis tik vardai ir pavardės,
-- bet išvesti visi darbuotojai)

select firstname, lastname
from employees;

-- 3. Filtruokite pagal skyrius: gaukite darbuotojų sąrašą, kurie dirba
-- HR skyriuje. (TIP: jungti su departments lentele, bet turi būti išvesta bent
-- jau darbuotojų vardai ir pavardės, kurie ir dirba šiame skyriuje)

select * from employees as E
inner join departments as D
on E.departmentID = D.departmentID
where departmentname = 'HR';

-- 4. Surikiuokite darbuotojus: gaukite darbuotojų sąrašą, surikiuotą pagal
-- jų įdarbinimo datą didėjimo tvarka. (TIP: apie darbuotojus išveskite visą arba
-- pasirinktą informaciją, bet turi būti surikiuoti kaip pasakyta)

select * from employees
order by hiredate asc;

-- 5. Suskaičiuokite darbuotojus: raskite kiek iš viso įmonėje dirba darbuotojų.
-- (TIP: turi išsivesti vienas skaičiukas su darbuotojų skaičiumi)

select count(*) from employees;

-- 6. Sujunkite darbuotojus su skyriais: išveskite bendrą darbuotojų sąrašą,
-- šalia kiekvieno darbuotojo nurodant skyrių kuriame dirba. (TIP: būtų geriausia
-- jeigu būtų pateikta bent jau darbuotojų vardai ir pavardės, bei skyrių
-- pavadinimai, bet galite išvesti ir daugiau informacijos, netinka jei bus
-- pateikti tik darbuotojų id)

select E.employeeID, E.firstname, E.lastname, D.departmentID, D.departmentname
from employees as E
inner join departments as D 
on E.departmentID = D.departmentID;

-- 7. Apskaičiuokite vidutinį atlyginimą: suraskite koks yra vidutinis
-- atlyginimas įmonėje tarp visų darbuotojų. (TIP: turi gautis vienas skaičius
-- kaip atsakymas, kuriame aiškiai matytųsi visų darbuotojų bendras atlyginimo
-- vidurkis) (TIP2: atkreipkite dėmesį kad kiekvienas darbuotojas turi kelis
-- atlyginimus, jeigu sugebėsite ištraukti kiekvienam darbuotojai naujausią
-- pagal datą ir tik iš jo skaičiuoti vidurkį būtų labai super, bet jei nesigaus
-- reikėtų paimti bent jau bendrą lentelės vidurkį)

select round(avg(S.salaryamount), 2) as average_salary
from (
select S.employeeID, S.salaryamount
from salaries as S
where S.salarystartdate = (
select max(S2.salarystartdate)
from salaries as S2
where S2.employeeID = S.employeeID
)
) as latest_salary;

-- Neveikia

-- 8. Išfiltruokite ir suskaičiuokite: raskite kiek darbuotojų dirba IT skyriuje.
-- (TIP: turite gauti tik vieną skaičių su atsakymu, jokių darbuotojų
-- nereikia išvedinėti)

select count(*)
from employees as E
inner join departments as D 
on E.departmentID = D.departmentID
where departmentname = 'IT';

-- 9. Išrinkite unikalias reikšmes: gaukite unikalių siūlomų darbo pozicijų
-- sąrašą iš jobpositions lentelės. (TIP: jobpositions yra darbo skelbimai,
-- kurie nėra susiję su tikrais darbuotojais, bet tai nereiškia, kad šioje
-- lentelėje nėra duomenų, yra, tik nereikia su niekuo jungti) (TIP2: turite
-- gauti tik pavadinimų sąrašą)

select positiontitle from jobpositions
group by positiontitle;

-- 10. Išrinkite pagal datos rėžį: gaukite darbuotojus, kurie buvo nusamdyti
-- tarp 2020-02-01 ir 2020-11-01. (TIP: suraskite nurodytus darbuotojus ir
-- išveskite visą ar pasirinktą informaciją apie juos)

select * from employees
where hiredate >= '2020-02-01' and hiredate <= '2020-11-01';

-- 11. Darbuotojų amžius: gaukite kiekvieno darbuotojo amžių pagal tai kada
-- jie yra gimę. (TIP: išveskite bent jau darbuotojų vardus ir pavardes, dėl
-- pasitikrinimo būtų gerai ir gimimo metai, bei išskaičiuotą amžiaus stulpelį)

select firstname, lastname, dateofbirth, timestampdiff(year, dateofbirth, curdate()) as age
from employees;

-- 12. Darbuotojų el. pašto adresų sąrašas: gaukite visų darbuotojų el. pašto
-- adresų sąrašą abėcėline tvarka. (TIP: neišvedinėkite nieko ko neprašo užduotis,
-- t.y. reikia tik el. pašto adresų ir daugiau nieko)

select email from employees 
order by email asc;

-- 13. Darbuotojų skaičius pagal skyrių: suraskite kiek kiekviename skyriuje
-- dirba darbuotojų. (TIP: išveskite tik skyrių pavadinimus ir kiekius kiek
-- kiekviename skyriuje dirba darbuotojų)

select D.departmentname, count(E.employeeID) as employee_count
from departments as D
inner join employees as E 
on D.departmentID = E.departmentID
group by D.departmentname;

-- 14. Darbštus darbuotojas: išrinkite visus darbuotojus, kurie turi 3 ar
-- daugiau įgūdžių (skills). (TIP: turite išvesti ne tik sąsają tarp duomenų,
-- bet ir pačių darbuotojų bent vardus su pavardėmis, galima aišku pateikti
-- ir daugiau informacijos apie tokius darbuotojus kurie turi tiek įgūdžių)

select E.firstname, E.lastname, E.dateofbirth, E.employeeID, ES.employeeskillID
from employees as E
inner join employeeskills as ES
on E.employeeID = ES.employeeID
inner join skills as S
on ES.skillID = S.skillID
where employeeskillID >= 3;

-- 15. Vidutinė papildomos naudos kaina: apskaičiuokite vidutines papildomų
-- naudų išmokų (benefits lentelė) išlaidas darbuotojams. (TIP: įmonė turi
-- siūlomų naudų paketą, raskite tiesiog vidurkį kiek vidutiniškai viena
-- nauda kainuoja, čia jums nereikia jungti su jokiais darbuotojais ar aiškintis
-- kokia kaina susidaro iš darbuotojų kurie yra pasirinkę šias naudas)

select round(avg(cost), 2) from benefits;

-- 16. Jaunausias ir vyriausias darbuotojai: suraskite jaunausią ir vyriausią
-- darbuotoją įmonėje. (TIP: jeigu gaunasi išveskite per vieną užklausą, jeigu
-- ne išveskite per dvi atskiras užklausas) (TIP2: išveskite ne tik amžių ar
-- gimimo datą, bet ir visą informaciją apie darbuotojus)

(
select * from employees
order by dateofbirth asc
limit 1
)
union
(
select * from employees
order by dateofbirth desc
limit 1
);

-- 17. Skyrius su daugiausiai darbuotojų: suraskite kuriame skyriuje dirba
-- daugiausiai darbuotojų. (TIP: suraskite kuriame skyriuje yra daugiausiai
-- darbuotojų ir išveskite šio skyriaus informaciją, pvz jo pavadinimą, kiek
-- darbuotojų jame yra ir kt.)

select D.*
from departments as D
inner join employees as E
on D.departmentID = E.departmentID
group by D.departmentID
order by count (E.employeeID) desc
limit 1;

 -- Neveikia:(
 
-- 18. Tekstinė paieška: suraskite visus darbuotojus su žodžiu "excellent"
-- jų darbo atsiliepime (performancereviews lentelė). (TIP: jeigu gaunasi tai
-- išveskite darbuotojų kurie turi tokius aprašymus informaciją, o jeigu
-- nesigauna tai bent jau tuos atsiliepimus kurie atitinka sąlygą)

select * from performancereviews as PW
inner join employees as E
on E.employeeID = PW.employeeID
where reviewtext like '%excellent%';

-- 19. Darbuotojų telefono numeriai: išveskite visų darbuotojų ID su jų
-- telefono numeriais. (TIP: čia reikia išveskite tik ID ir jų telefono numerius,
-- jokia kita informacija nereikalinga)

select employeeID, phone from employees;

-- 20. Darbuotojų samdymo mėnesis: suraskite kurį mėnesį buvo nusamdyta
-- daugiausiai darbuotojų. (TIP: jums reikia išvesti tik mėnesio numerį arba
-- pavadinimą kuris atitiko duotą sąlygą, bei kiek darbuotojų tą mėnesį buvo
-- įdarbinta, neišvedinėkite viso sąrašo ir neieškokite konkrečių darbuotojų)



-- 21. Darbuotojų įgūdžiai: išveskite visus darbuotojus, kurie turi įgūdį
-- "Communication". (TIP: jeigu galite išveskite ir šių darbuotojų informaciją,
-- tokią kaip vardas ar pavardė, bet jei nesigauna tai bent šių darbuotojų ID)

select E.employeeID, E.firstname, E.lastname
from employeeskills as ES
inner join employees as E
on ES.employeeID = E.employeeID
inner join skills as S
on ES.skillID = S.skillID
where skillname = 'Communication';

-- 22. Sub-užklausos: suraskite kuris darbuotojas įmonėje uždirba daugiausiai
-- ir išveskite visą jo informaciją. (TIP: turi matytis tokio darbuotojo informacija,
-- o ne tik surastas didžiausias atlyginimas)

select E.*, S.salaryamount
from employees as E
inner join salaries as S
on E.employeeID = S.employeeID
order by s.salaryamount desc
limit 1;


-- 23. Grupavimas ir agregacija: apskaičiuokite visas įmonės išmokų (benefits
-- lentelė) išlaidas. (TIP: suskaičiuokite kiek iš viso įmonė išleidžia dėl visų
-- papildomų naudų, turi gautis vienas ir bendras skaičius, įvertinant, kad vieni
-- darbuotojai turi daugiau naudų, kiti mažiau, vieni)



-- 24. Parodykite visus galimus įgūdžius. (TIP: turite parodyti tik įgūdžių pavadinimus,
-- su darbuotojais jungti nereikia)

select skillname from skills;

-- 25. Atostogų užklausos: išveskite sąrašą atostogų prašymų (leaverequests),
-- kurie laukia patvirtinimo. (TIP: turite išvesti tik tokius prašymus, kurie
-- atitinka nurodytą sąlygą, darbuotojų išvedinėti nereikia)



-- 26. Darbo atsiliepimas: išveskite darbuotojus, kurie darbo atsiliepime yra
-- gavę 5 balus. (TIP: užduotyje parašyta išvesti darbuotojus, vadinasi, reikia
-- surasti ne tik tokius atsiliepimus, bet ir sujungti su darbuotojais, bei
-- išvesti bent jau jų vardus ir pavardes)



-- 27. Papildomų naudų registracijos: išveskite visus darbuotojus, kurie yra
-- užsiregistravę į "Health Insurance" papildomą naudą (benefits lentelė).
-- (TIP: turite sujungti su darbuotojais ir išvesti bent jau jų vardus ir
-- pavardes, kurie atitinka nurodytą sąlygą)



-- 28. Atlyginimų pakėlimas: parodykite kaip atrodytų atlyginimai darbuotojų,
-- dirbančių "Finance" skyriuje, jeigu jų atlyginimus pakeltume 10 %. (TIP:
-- turite parodyti bent šiek tiek darbuotojų informacijos, pvz vardus pavardes,
-- jų atlyginimus, ir pakeltus atlyginimus, o kad žinoti kurie darbuotojai tinka,
-- reikės jungti su departments lentele)



-- 29. Efektyviausi darbuotojai: raskite 5 darbuotojus, kurie turi didžiausią
-- darbo vertinimo (performance lentelė) reitingą. (TIP: jei nesigauna išveskite
-- bent tuos atsiliepimus, bet būtų geriau jei pavyktų išvesti ir pačių darbuotojų
-- informaciją)



-- 30. Atostogų užklausų istorija: gaukite visą atostogų užklausų istoriją
-- (leaverequests lentelė) darbuotojo, kurio id yra 1. (TIP: išveskite visą
-- informaciją apie tokius šio darbuotojo prašymus, paties darbuotojo nereikia)



-- 31. Atlyginimų diapozono analizė: nustatykite atlyginimo diapazoną (minimalų
-- ir maksimalų) kiekvienai darbo pozicijai. (TIP: nemaišykit su jobspositions nes ten
-- yra skelbimų lenta ir ji su darbuotojais nėra susijus) (TIP2: turite išvesti
-- skyriaus pavadinimą, kokia mažiausia alga jame yra, ir kokia didžiausia alga)
-- (TIP3: būtų geriausia jei imtumėt vėliausias datas, o ne bet kurias pasitaikusias)



-- 32. Darbo atsiliepimo istorija: gaukite visą istoriją apie darbo atsiliepimus
-- (performancereviews lentelė), darbuotojo, kurio id yra 2. (TIP: išveskite visą
-- tokių atsiliepimų informaciją, paties darbuotojo informacijos nereikia)



-- 33. Papildomos naudos kaina vienam darbuotojui: apskaičiuokite bendras papildomų
-- naudų išmokų išlaidas vienam darbuotojui (benefits lentelė). (TIP: turite gauti vieną
-- skaičių kaip galutinį atsakymą, šis skaičius yra bendras vidurkis kiek yra vidutiniškai
-- išleidžiama ant vieno darbuotojo per jo naudas)



-- 34. Geriausi įgūdžiai pagal skyrių: išvardykite dažniausiai pasitaikančius
-- įgūdžius kiekviename skyriuje. (TIP: turite išvesti skyrių pavadinimus, o šalia
-- jų koks įgūdis jame pasitaikė dažniausiai, o jei taip sutraukti nesigauna tai bent
-- išvesti kiekvieną skyrių, jo įgūdį ir kiek kartų kartojasi jame ir surikiuoti kad
-- matytųsi bent pagal dažnumą)



-- 35. Atlyginimo augimas: apskaičiuokite procentinį atlyginimo padidėjimą kiekvienam
-- darbuotojui, lyginant su praėjusiais metais. (TIP: turi matytis darbuotojų informacija,
-- pvz vardai ir pavardės, taip pat kiek procentų atlyginimas paaugo, o jei nepaaugo rašyti
-- 0 procentų)



-- 36. Darbuotojų išlaikymas: raskite darbuotojus, kurie įmonėje dirba daugiau
-- nei 5 metai ir kuriems per tą laiką nebuvo pakeltas atlyginimas. (TIP: išveskite
-- tokių darbuotojų informaciją, o ne tik id)



-- 37. Darbuotojų atlyginimų analizė: suraskite kiekvieno darbuotojo atlygį
-- (atlyginimas (salaries lentelė) + išmokos už papildomas naudas (benefits lentelė))
-- ir surikiuokite darbuotojus pagal bendrą atlyginimą mažėjimo tvarka. (TIP: turi
-- matytis ir darbuotojo informacija ir jo atlyginimas, ir jo naudų bendra vertė)



-- 38. Darbuotojų darbo atsiliepimų tendencijos: išveskite kiekvieno darbuotojo vardą
-- ir pavardę, nurodant ar jo darbo atsiliepimas (performancereviews lentelė)
-- pagerėjo ar sumažėjo. (TIP: turi matytis kiekvienas darbuotojas, jo informacija ir
-- vertinimas ar pagerėjo ar ne)


