/*

Program is used to write 
        CASE 3
data to MongoDB (store them into AGENT_OPTIMIZATION / AGENTS)

Ladislav Körösi, František Duchoň
NCR - National Centre of Robotics

*/


#include <bson.h>
#include <mongoc.h>
#include <stdio.h>

int main (int argc, char *argv[])
{
    mongoc_client_t *client;
    mongoc_collection_t *collection;
    mongoc_cursor_t *cursor;
    bson_error_t error;
    bson_oid_t oid;
    bson_t *doc;
    
    printf("Begin.\n");
    
    // init the connector
    mongoc_init ();

    // make connection
    client = mongoc_client_new ("mongodb://localhost:27017/");
    if (!client)
    {
       printf("No client connection\n");
       return EXIT_FAILURE;
    }
    
    collection = mongoc_client_get_collection (client, "AGENT_OPTIMIZATION", "AGENTS");
    // remove all documents
    printf("Removing all documents in AGENT_OPTIMIZATION / AGENTS\n");
    doc = bson_new ();
    if (!mongoc_collection_remove (collection, MONGOC_REMOVE_NONE, doc, NULL, &error))
    {
       printf ("Delete failed: %s\n", error.message);
    }
    bson_destroy (doc);
    
    // write new documents (case 3a, 3b and 3c)
    
    printf("Writing case 3a\n");
    // case 3a with flag result_DONE = 0
    // result should be result_optimal_number_of_agents = 3.214, rounded to 4
    doc = bson_new ();
    bson_oid_init (&oid, NULL);
    BSON_APPEND_OID (doc, "_id", &oid);
    // all written as str into MongoDB
    // request_id is a unique ID (value INT)
    BSON_APPEND_UTF8 (doc, "request_id", "1");
    // size of the matrices NxN (value INT)
    BSON_APPEND_UTF8 (doc, "N", "5");
    // distance matrix encoded as vector (values FLOAT) ended with comma
    BSON_APPEND_UTF8 (doc, "distance_matrix", "0,50,120,205,0,0,0,0,0,80,0,0,0,85,170,0,0,0,0,85,30,0,0,0,0,");
    // flowrate matrix encoded as vector (values FLOAT) ended with comma
    BSON_APPEND_UTF8 (doc, "flowrate_matrix", "0,9,5,6,0,0,0,0,0,9,0,0,0,2,3,0,0,0,0,8,-1,0,0,0,0");
    // agent speed (value Float)
    BSON_APPEND_UTF8 (doc, "agent_speed", "50");
    // agent load time (value Float)
    BSON_APPEND_UTF8 (doc, "agent_load_time", "0.75");
    // agent unload time (value Float)
    BSON_APPEND_UTF8 (doc, "agent_unload_time", "0.5");
    // agent capacity (value Float)
    BSON_APPEND_UTF8 (doc, "agent_capacity", "1");
    // agent availability (value Float)
    BSON_APPEND_UTF8 (doc, "agent_availability", "0.95");
    // traffic factor (value Float)
    BSON_APPEND_UTF8 (doc, "traffic_factor", "0.9");
    // operator efficiency (value Float)
    BSON_APPEND_UTF8 (doc, "operator_efficiency", "1.0");
    // result returned and written by optimisation - optimal number of agent (value Float)
    BSON_APPEND_UTF8 (doc, "result_optimal_number_of_agents", "0.0");
    // result returned and written by optimisation - optimal number of agent (value INT)
    BSON_APPEND_UTF8 (doc, "result_optimal_number_of_agents_rounded", "0.0");
    // flag written after optimisation - reseult were written (value INT)
    BSON_APPEND_UTF8 (doc, "result_DONE", "0");
    // write data to MongoDB
    if (!mongoc_collection_insert (collection, MONGOC_INSERT_NONE, doc, NULL, &error)) {
        printf ("%s\n", error.message);
    }
    bson_destroy (doc);
    
    printf("Writing case 3b\n");
    // case 3b with flag result_DONE = 1 (will not be processed by optimization)
    doc = bson_new ();
    bson_oid_init (&oid, NULL);
    BSON_APPEND_OID (doc, "_id", &oid);
    BSON_APPEND_UTF8 (doc, "request_id", "2");
    BSON_APPEND_UTF8 (doc, "N", "5");
    BSON_APPEND_UTF8 (doc, "distance_matrix", "0,50,120,205,0,0,0,0,0,80,0,0,0,85,170,0,0,0,0,85,30,0,0,0,0,");
    BSON_APPEND_UTF8 (doc, "flowrate_matrix", "0,9,5,6,0,0,0,0,0,9,0,0,0,2,3,0,0,0,0,8,-1,0,0,0,0");
    BSON_APPEND_UTF8 (doc, "agent_speed", "50");
    BSON_APPEND_UTF8 (doc, "agent_load_time", "0.75");
    BSON_APPEND_UTF8 (doc, "agent_unload_time", "0.5");
    BSON_APPEND_UTF8 (doc, "agent_capacity", "1");
    BSON_APPEND_UTF8 (doc, "agent_availability", "0.95");
    BSON_APPEND_UTF8 (doc, "traffic_factor", "0.9");
    BSON_APPEND_UTF8 (doc, "operator_efficiency", "1.0");
    BSON_APPEND_UTF8 (doc, "result_optimal_number_of_agents", "0.0");
    BSON_APPEND_UTF8 (doc, "result_optimal_number_of_agents_rounded", "0.0");
    BSON_APPEND_UTF8 (doc, "result_DONE", "1");
    if (!mongoc_collection_insert (collection, MONGOC_INSERT_NONE, doc, NULL, &error)) {
        printf ("%s\n", error.message);
    }
    bson_destroy (doc);
    
    printf("Writing case 3c\n");
    // case 3c with flag result_DONE = 0 as case 1a except agent_capacity (agent_capacity = 2)
    // result should be result_optimal_number_of_agents = 2.365, rounded to 3
    doc = bson_new ();
    bson_oid_init (&oid, NULL);
    BSON_APPEND_OID (doc, "_id", &oid);
    BSON_APPEND_UTF8 (doc, "request_id", "3");
    BSON_APPEND_UTF8 (doc, "N", "5");
    BSON_APPEND_UTF8 (doc, "distance_matrix", "0,50,120,205,0,0,0,0,0,80,0,0,0,85,170,0,0,0,0,85,30,0,0,0,0,");
    BSON_APPEND_UTF8 (doc, "flowrate_matrix", "0,9,5,6,0,0,0,0,0,9,0,0,0,2,3,0,0,0,0,8,-1,0,0,0,0");
    BSON_APPEND_UTF8 (doc, "agent_speed", "50");
    BSON_APPEND_UTF8 (doc, "agent_load_time", "0.75");
    BSON_APPEND_UTF8 (doc, "agent_unload_time", "0.5");
    BSON_APPEND_UTF8 (doc, "agent_capacity", "2");
    BSON_APPEND_UTF8 (doc, "agent_availability", "0.95");
    BSON_APPEND_UTF8 (doc, "traffic_factor", "0.9");
    BSON_APPEND_UTF8 (doc, "operator_efficiency", "1.0");
    BSON_APPEND_UTF8 (doc, "result_optimal_number_of_agents", "0.0");
    BSON_APPEND_UTF8 (doc, "result_optimal_number_of_agents_rounded", "0.0");
    BSON_APPEND_UTF8 (doc, "result_DONE", "0");
    if (!mongoc_collection_insert (collection, MONGOC_INSERT_NONE, doc, NULL, &error)) {
        printf ("%s\n", error.message);
    }
    bson_destroy (doc);
    
    printf("End.\n");
    
    mongoc_collection_destroy (collection);
    mongoc_client_destroy (client);
    mongoc_cleanup ();

    return 0;
}
