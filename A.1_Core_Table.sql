-----------------------------------------
--1
-----------------------------------------
-- CORE TABLE
-- patients with referral between jan08 - dec16 and 
-- have f2f contact within 6 months of date of referral
-----------------------------------------
SELECT * 

--INTO SQLCRIS_User.dbo.Afernandes_CoreTable21092017

--from
--				(
--							SELECT 
--										--Distinct 
--										(Referral.BrcId) as ReferralBrcid,
--										Event.BrcId as EventBrcid,
--										Accepted_Date as Referral_accepted_date,
--										Discharge_Date as Referral_end_date,
--										Referral.Spell_Number,
--										Event.Start_Date as Event_start_date,
--										Event_Type_Of_Contact_ID,
--										Referral.cn_doc_id as Referral_id,
--										Event.CN_Doc_ID as Event_id
									
--							FROM 
--										SQLCRIS.dbo.Referral

--							INNER JOIN 	
--										Event

--							on 			
--										Event.brcid = Referral.brcid

--							WHERE 
--										(
--										Accepted_Date BETWEEN '01-JAN-2008' and '31-DEC-2016'
--										AND
--											(
--											(Event.Event_Type_Of_Contact_ID LIKE '%face%')
--											AND 
--											Event.Start_Date < (DATEADD(mm, 6, Accepted_Date)) 
--											AND
--											Event.Start_Date > (Accepted_Date)
--											)
--										) 
--				) CoreCohort
-- (1850787 row(s) affected)
-- Table name for above query: SQLCRIS_User.dbo.Afernandes_CoreTable21092017 
