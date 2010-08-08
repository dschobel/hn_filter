CREATE OR REPLACE FUNCTION update_statistics(timeframe integer) RETURNS VOID as $$
DECLARE
mn REAL;
md REAL;
minimum INTEGER;
maximum INTEGER;
BEGIN
    IF timeframe = -1 THEN --generate stats for all time
        select into mn avg(score) from stories;
        select into minimum min(score) from stories;
        select into maximum max(score) from stories;
    ELSE 
        select into mn avg(score) from stories where age(created_at) < (timeframe || ' days')::INTERVAL;
        select into minimum min(score) from stories where age(created_at) < (timeframe || ' days')::INTERVAL;
        select into maximum max(score) from stories where age(created_at) < (timeframe || ' days')::INTERVAL;
    END IF;
    md := 12.3;
    --first try to update the value
    UPDATE statistics SET mean = mn, min = minimum, max = maximum, median = md, updated_at = current_timestamp WHERE timeframe_in_days = timeframe;
    IF found THEN
        RETURN;
    END IF;
    --not found so we need to insert
    INSERT INTO statistics(timeframe_in_days,mean,median, min, max, updated_at) VALUES(timeframe,mn,md,minimum,maximum,current_timestamp);
END ;
$$ LANGUAGE plpgsql;
