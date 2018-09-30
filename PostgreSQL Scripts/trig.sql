create trigger price after insert on includes for each row execute procedure update_cart_price();

create trigger price after insert on _order for each row execute procedure update_price();

create trigger del_price after delete on includes for each row execute procedure update_cart_price();
