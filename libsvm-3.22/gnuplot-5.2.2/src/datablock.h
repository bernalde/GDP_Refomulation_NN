/*
 * $Id: datablock.h,v 1.3.4.1 2017/08/30 18:37:06 sfeam Exp $
 */
void datablock_command __PROTO((void));
char **get_datablock __PROTO((char *name));
char *parse_datablock_name __PROTO((void));
void gpfree_datablock __PROTO((struct value *datablock_value));
void append_to_datablock __PROTO((struct value *datablock_value, const char * line));
int datablock_size __PROTO((struct value *datablock_value));
