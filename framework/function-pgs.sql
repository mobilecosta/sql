Create or Replace Function sys_strzero
(  in in_num numeric,
   in in_size integer
)
Returns varchar
as
$$
Begin
   return lpad(coalesce(in_num::varchar, '0'), in_size, '0');
End;
$$ language plpgsql;