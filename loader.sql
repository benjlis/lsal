-- load program
\copy piir_eval.ground_truth_stage(label_studio_id, creator, completed, doc, start_idx, end_idx, entity_code) from 'loader.csv' csv
-- load from stage
insert into piir_eval.ground_truth (test_id, entity_code, 
    start_idx, end_idx, label_studio_id, creator, completed)
select t.test_id,
       case when ts.entity_code = 'SSN'     then 'ssn'
            when ts.entity_code = 'Account' then 'ban'
            when ts.entity_code = 'Phone'   then 'phone_number'
       end entity_code, 
       ts.start_idx, ts.end_idx, 
       ts.label_studio_id, ts.creator, ts.completed
    from piir_eval.tests t join piir_eval.ground_truth_stage ts
        on (t.doc_id = ts.doc);

update piir_eval.ground_truth gt
   set entity_text = (select substr(t.body, 
                                    gt.start_idx+1, 
                                    gt.end_idx-start_idx)
                            from piir_eval.tests t
                            where t.test_id = gt.test_id);
