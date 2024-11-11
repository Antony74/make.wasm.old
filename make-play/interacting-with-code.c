// interacting-with-code.c
//
// Usage:
//     emcc -O2 -s NODERAWFS=1 --js-library library.js interacting-with-code.c
//     node a.out.js

#include <stdio.h>
#include <spawn.h>

int posix_spawn(pid_t *pid, const char *path,
                       const posix_spawn_file_actions_t *file_actions,
                       const posix_spawnattr_t *attrp,
                       char *const argv[], char *const envp[]);

int not_posix_spawn(pid_t *pid, const char *path,
                       const posix_spawn_file_actions_t *file_actions,
                       const posix_spawnattr_t *attrp,
                       char *const argv[], char *const envp[]);

int main() {
    pid_t pid = -1;

    int result = posix_spawn(&pid, "fakeExecutable", 0, 0, 0, 0);

    printf("result %d\n", result);

    return 0;
}
