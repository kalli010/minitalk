/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: zelkalai <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/20 12:16:56 by zelkalai          #+#    #+#             */
/*   Updated: 2024/05/23 09:37:34 by zelkalai         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

void	handle_sigusr(int sig, siginfo_t *info, void *context)
{
	static int	c;

	(void)info;
	(void)context;
	if (sig == SIGUSR2)
		c++;
}

void	send_signals(char c, double server_pid)
{
	int	i;

	i = 0;
	while (i < 8)
	{
		if (c & (1 << i))
		{
			if (kill(server_pid, SIGUSR1))
			{
				ft_printf("1");
				exit(1);
			}
		}
		else
		{
			if (kill(server_pid, SIGUSR2))
			{
				ft_printf("0");
				exit(1);
			}
		}
		usleep(1000);
		i++;
	}
}

int	main(int argc, char **argv)
{
	int					j;
	double				server_pid;
	struct sigaction	sa;

	sa.sa_flags = SA_SIGINFO;
	sa.sa_sigaction = &handle_sigusr;
	sigemptyset(&sa.sa_mask);
	if (sigaction(SIGUSR2, &sa, NULL) == -1)
	{
		ft_printf("SIGUSR2 error");
		return (1);
	}
	server_pid = ft_atoi(argv[1]);
	j = 0;
	if (argc != 3 || argv[1][0] == '\0' || argv[2][0] == '\0')
		return (1);
	if (server_pid <= 0 || server_pid > 4194304)
		return (1);
	while (argv[2][j])
	{
		send_signals(argv[2][j], server_pid);
		j++;
	}
	return (0);
}
