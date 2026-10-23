# Where to look, per platform

Search for these to find the execution contexts (step 2) and how they talk
(step 5). A match is a lead, not a fact: read it before you use it.

| Platform | Who runs (contexts) | How they talk |
|---|---|---|
| Bare-metal MCU | `main()` `while (1)` super-loop; `*_IRQHandler`, vector table in `startup_*.s`; HAL callbacks `HAL_*_Callback`; timer periods in init code or a CubeMX `.ioc` | `volatile` flags, ring buffers, `__atomic_*`, disabling interrupts |
| RTOS (FreeRTOS, CMSIS-OS, RTX, Zephyr) | `xTaskCreate`, `osThreadNew`, `osThreadDef`/`osThreadCreate`, `K_THREAD_DEFINE`; priority + stack in the attribute struct; period from `osDelay`, `vTaskDelay(Until)`, `k_sleep`; software timers `xTimerCreate`, `osTimerNew` | queues (`xQueue*`, `osMessageQueue*`, `k_msgq`), semaphores / mutexes, event flags, task notifications, atomics |
| Linux C / C++ | `main`, `pthread_create`, `std::thread`, `std::async`, `fork` / `exec`, signal handlers (`sigaction`), `epoll` / `select` loops | mutex / condition variable, `std::atomic`, pipes, sockets, shared memory |
| Qt (C++) | `QApplication::exec()` main event loop; `QThread` subclasses or `moveToThread`; `QTimer` (interval = period); `QtConcurrent::run`, `QThreadPool`; `QMetaObject::invokeMethod(context, lambda)` used as "run this on that thread" | signals / slots, `invokeMethod`, `QMutex`, events, `shared_ptr` handed through a queued call |
| Python | `if __name__ == "__main__"`, `threading.Thread`, `threading.Timer`, `concurrent.futures`, `multiprocessing`, `asyncio.run` / `create_task`; GUI / web-UI loops (`mainloop()`, `exec()`, NiceGUI `ui.run` + `ui.timer` + `run.io_bound`, FastAPI / uvicorn) | `queue.Queue`, `asyncio.Queue`, `threading.Event` / `Lock`, `multiprocessing.Queue`, sockets |
| JavaScript / Node | the event loop; `setTimeout` / `setInterval`; `worker_threads`, Web Workers; `child_process`; HTTP handlers (`app.get`, `router.*`) | callbacks, Promises / `await`, `EventEmitter`, `postMessage`, sockets |
| Go | `main`, `go func`, `time.Ticker`, `http.HandleFunc` / router | channels, `select`, `sync.Mutex`, `context` cancel |
| Rust | `main`, `std::thread::spawn`, `#[tokio::main]`, `tokio::spawn`, interval timers | channels (`mpsc`, `tokio::sync`), `Arc<Mutex>`, atomics |
| Web backend (any language) | request handlers, middleware chain, background workers / job queues, cron / schedulers, services in `docker-compose.yml` | HTTP / RPC, message brokers (queue names), the database as shared state, caches |
| Several programs in one repo | the top-level build or `README`, launch / service files, protocol docs (`*.yaml`, `*.proto`, spec docs) | the wire: USB, serial, TCP, MQTT, HTTP; who asks, who answers; how replies are matched (transaction ids) |

## Traps: what really runs where, and what is really unsafe

| Platform | Trap |
|---|---|
| Any | A callback stored in a field (`transport.on_bytes = f`, a function pointer) runs on the thread that **calls** it, not the one that set it. |
| Any | A lock held while waiting for a reply blocks every other sender for that long (and a "stop all" behind it). |
| MCU / RTOS | Same-priority tasks preempt each other at any line; an ISR cuts into everything below its priority. Shared multi-field data needs one writer or a lock. |
| Qt | An `AutoConnection` is queued only when the emitter's thread ≠ the receiver's thread; otherwise the slot runs at once, inside `emit`. Slots of one signal run in connect order. A queued signal needs its argument types registered (`qRegisterMetaType`). `QCheckBox::clicked` (user only) vs `toggled` (also from code). |
| Python | The GIL makes a plain assignment or `list.append` safe across threads, but not `x += 1` or check-then-act. Python threads have no priorities. |
| asyncio / Node | One slow (blocking) call in a coroutine or callback freezes the whole loop. |
| Web UI | The page only changes when the UI loop redraws: look for the timer or "version" counter it polls. |

State machines (step 4), any language: an enum or set of named states plus a
`switch` / `match` / dict dispatch on it; names like `state`, `status`, `phase`,
`step`, `miniStep`, `mode`; entry guards (`state != lastState`); one struct or
object per unit in an array or map.
