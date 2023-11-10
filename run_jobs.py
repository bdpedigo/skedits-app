from pkg.workers import extract_edit_info  # noqa: F401
from taskqueue import TaskQueue

tq = TaskQueue("https://sqs.us-west-2.amazonaws.com/629034007606/ben-skedit")


def stop_fn(elapsed_time):
    if elapsed_time > 3600 * 8:
        return True


lease_seconds = 4 * 3600

tq.poll(lease_seconds=lease_seconds, verbose=False, tally=False)
