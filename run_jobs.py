from pkg.workers import create_sequences  # noqa: F401
from taskqueue import TaskQueue

tq = TaskQueue("https://sqs.us-west-2.amazonaws.com/629034007606/ben-skedit-dead")


def stop_fn(elapsed_time):
    if elapsed_time > 3600 * 8:
        return True


lease_seconds = 3 * 3600

tq.poll(lease_seconds=lease_seconds, verbose=False, tally=False)
