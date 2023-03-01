select count(*) redactions, count(distinct doc) cables
   from piir_eval.ground_truth_stage;

select entity_code, count(entity_code) redactions, count(distinct doc) cables 
   from piir_eval.ground_truth_stage 
   group by entity_code;

select count(*) cables_with_no_redactions 
   from (select doc_id from piir_eval.tests except 
         select doc from piir_eval.ground_truth_stage) n;

select creator, count(*) redactions, count(distinct doc) cables
   from piir_eval.ground_truth_stage 
   group by creator;

select creator, entity_code, count(*) redactions, count(distinct doc) cables 
   from piir_eval.ground_truth_stage 
   group by creator, entity_code;