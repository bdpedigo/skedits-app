# %%
from functools import partial

import caveclient as cc
from pkg.workers import extract_edit_info
from taskqueue import TaskQueue

client = cc.CAVEclient("minnie65_phase3_v1")

query_neurons = client.materialize.query_table("connectivity_groups_v507")

tasks = (partial(extract_edit_info, root_id) for root_id in query_neurons["pt_root_id"])

tq = TaskQueue("https://sqs.us-west-2.amazonaws.com/629034007606/ben-skedit")

tq.insert(tasks)
