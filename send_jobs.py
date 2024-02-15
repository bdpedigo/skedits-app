# %%
from functools import partial

from pkg.workers import create_sequences
from taskqueue import TaskQueue

import caveclient as cc

client = cc.CAVEclient("minnie65_phase3_v1")

query_neurons = client.materialize.query_table("connectivity_groups_v507")

tasks = (
    partial(create_sequences, root_id) for root_id in query_neurons["pt_root_id"]
)

tq = TaskQueue("https://sqs.us-west-2.amazonaws.com/629034007606/ben-skedit")

tq.insert(tasks)

