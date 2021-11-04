/*

Program is used to read all data from MongoDB (stored in AGENT_OPTIMIZATION / AGENTS)
to test the presence of data in database

Ladislav Körösi, František Duchoň
NCR - National Centre of Robotics

*/

#include <bson/bson.h>
#include <mongoc/mongoc.h>
#include <stdio.h>

int main (int argc, char *argv[])
{
   mongoc_database_t *database;
   mongoc_client_t *client;
   mongoc_collection_t *collection;

   mongoc_cursor_t *cursor;
   const bson_t *doc;
   bson_t *query;
   char *str;
   int i = 0;
   
   printf("Begin.\n");

   // init the conenctor
   mongoc_init ();

   // make connection
   client = mongoc_client_new("mongodb://localhost:27017/");
   if (!client)
   {
      printf("No client connection\n");
      return EXIT_FAILURE;
   }

   // set client name, database and collection
   mongoc_client_set_appname (client, "ncr-client");
   database = mongoc_client_get_database (client, "AGENT_OPTIMIZATION");
   collection = mongoc_client_get_collection (client, "AGENT_OPTIMIZATION", "AGENTS");
   // query without conditions
   query = bson_new ();
   
   cursor = mongoc_collection_find_with_opts (collection, query, NULL, NULL);
   // read all
   while (mongoc_cursor_next (cursor, &doc)) 
   {
      // store in char format
      str = bson_as_canonical_extended_json (doc, NULL);
      // print the document
      i++;
      printf ("Record no. %d : %s\n\n", i, str);
      bson_free (str);
   }
   if (i==0)
   {
      printf("No record found.\n");
   }
   printf("End.\n");
   
   mongoc_database_destroy(database);
   mongoc_cursor_destroy (cursor);
   mongoc_collection_destroy (collection);
   mongoc_client_destroy (client);
   bson_destroy (query);
   mongoc_cleanup ();   

   return 0;
}
